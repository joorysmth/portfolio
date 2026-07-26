-- FAREED Group System Migration
-- Run once in phpMyAdmin on fareed_db.

USE fareed_db;

-- Student identifier for grouping
ALTER TABLE users ADD COLUMN student_id VARCHAR(50) NULL;
ALTER TABLE users ADD UNIQUE KEY uq_student_id (student_id);

-- Groups managed by supervisors
CREATE TABLE IF NOT EXISTS groups (
    id INT AUTO_INCREMENT PRIMARY KEY,
    group_number INT NOT NULL,
    supervisor_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supervisor_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY uq_group_number (group_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Students in each group
CREATE TABLE IF NOT EXISTS group_members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    group_id INT NOT NULL,
    student_user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (group_id) REFERENCES groups(id) ON DELETE CASCADE,
    FOREIGN KEY (student_user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY uq_group_student (group_id, student_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Link submissions to a team/group
ALTER TABLE project_submissions ADD COLUMN group_id INT NULL;
ALTER TABLE project_submissions ADD CONSTRAINT fk_submission_group
    FOREIGN KEY (group_id) REFERENCES groups(id) ON DELETE SET NULL;
