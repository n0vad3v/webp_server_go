module webp_server_go

go 1.15

require (
	github.com/chai2010/webp v1.1.0
	github.com/gofiber/fiber/v2 v2.4.0
	github.com/sirupsen/logrus v1.6.0
	github.com/stretchr/testify v1.3.0
	golang.org/x/image v0.0.0-20200119044424-58c23975cae1
)

replace (
	github.com/chai2010/webp v1.1.0 => github.com/webp-sh/webp v1.2.0
	github.com/gofiber/fiber/v2 v2.4.0 => github.com/webp-sh/fiber/v2 v2.4.0
)
