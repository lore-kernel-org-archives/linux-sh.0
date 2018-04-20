From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2018 21:51:18 +0000
Subject: Re: [PATCH 4/4] sh: remove board_time_init() callback
Message-Id: <CAK8P3a2vh+BH_GJSPkc8D61+J2NK_e_HWJkuz6DVmb_Ln6ND0Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180420154933.3235131-1-arnd@arndb.de> <20180420154933.3235131-4-arnd@arndb.de>
In-Reply-To: <20180420154933.3235131-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Apr 20, 2018 at 5:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> @@ -41,8 +39,7 @@ static void __init sh_late_time_init(void)
>
>  void __init time_init(void)
>  {
> -       if (board_time_init)
> -               board_time_init();
> +       timer_init();

Testing revealed this to be broken, the fix is:

diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index a29eb989d81b..8a1c6c8ab4ec 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -39,7 +39,7 @@ static void __init sh_late_time_init(void)

 void __init time_init(void)
 {
- timer_init();
+ timer_probe();

  clk_init();

Let me know if you'd like me to resend the series with that typo fixed.

      Arnd
