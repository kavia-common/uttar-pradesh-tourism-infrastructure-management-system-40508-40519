-- V2__seed.sql
-- Seed default roles and initial admin user (password hash must be updated by backend upon first login)

-- Insert default roles
INSERT INTO roles (name) VALUES
    ('ADMIN'),
    ('PM'),
    ('ENGINEER'),
    ('AUDITOR')
ON CONFLICT (name) DO NOTHING;

-- Seed initial admin user with placeholder password hash
-- NOTE: Replace this hash via backend password reset/first-login flow
-- The below is a bcrypt-like placeholder string; NOT a real hash for security. Backend must update.
INSERT INTO users (username, email, password_hash, full_name, status)
VALUES ('admin', 'admin@example.com', '$2a$10$PLACEHOLDERINITIALPASSWORDHASHxxxxxxxxxxxxxxxxxxxxxxx', 'System Administrator', 'ACTIVE')
ON CONFLICT (username) DO NOTHING;

-- Map admin role to admin user
DO $$
DECLARE
  admin_id UUID;
  admin_role_id INT;
BEGIN
  SELECT id INTO admin_id FROM users WHERE username = 'admin';
  SELECT id INTO admin_role_id FROM roles WHERE name = 'ADMIN';

  IF admin_id IS NOT NULL AND admin_role_id IS NOT NULL THEN
    INSERT INTO user_roles(user_id, role_id)
    VALUES (admin_id, admin_role_id)
    ON CONFLICT DO NOTHING;
  END IF;
END;
$$;
