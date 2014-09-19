(setq package-archives (cons
                        '("SC"   . "http://joseito.republika.pl/sunrise-commander/")
                        package-archives
                        )
      )

(prelude-require-packages '(sunrise-commander))

(provide 'personal-sunrise-commander)
