BEGIN;

-- CREATE TABLE public.feature
-- (
--   PRIMARY KEY (id),
--   id  serial  NOT NULL,
-- );

-- CREATE TABLE public.tag 
-- (
--   PRIMARY KEY (id),
--   id  serial  NOT NULL,
-- );

CREATE TABLE public.banner
(
  PRIMARY KEY (id),
  id          serial    NOT NULL,
  content     text,
  feature_id  smallint  NOT NULL,
              -- CONSTRAINT FK_feature_id FOREIGN KEY (feature_id) REFERENCES public.feature (id) ON DELETE CASCADE,
  is_active   boolean,
  created_at  timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
  updated_at  timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE public.banner_to_tag
(
  PRIMARY KEY (id),
  id          serial  NOT NULL,
  tag_id  serial  NOT NULL,
              -- CONSTRAINT FK_tag_id FOREIGN KEY (tag_id) REFERENCES public.tag (id) ON DELETE CASCADE,
  banner_id   serial  NOT NULL,
              CONSTRAINT FK_banner_id FOREIGN KEY (banner_id) REFERENCES public.banner (id) ON DELETE CASCADE
);

COMMIT;
