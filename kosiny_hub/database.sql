CREATE TABLE IF NOT EXISTS kosiny_hub_settings (
    identifier VARCHAR(50) PRIMARY KEY,
    fly_enabled BOOLEAN DEFAULT FALSE,
    climb_enabled BOOLEAN DEFAULT FALSE,
    hub_color VARCHAR(20) DEFAULT 'blue'
);

INSERT INTO kosiny_hub_settings (identifier, fly_enabled, climb_enabled, hub_color) VALUES ('default', FALSE, FALSE, 'blue');