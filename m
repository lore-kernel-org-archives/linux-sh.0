From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 01 Dec 2014 09:36:24 +0000
Subject: Re: [PATCH V3 3/3] ARM: shmobile: Convert to genpd flags for PM clocks for R-mobile
Message-Id: <CAMuHMdVntNxw+zciOQfayfJbMMV+AqOyZMqeB2FY=Q5eA=r0rw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417163403-7070-1-git-send-email-ulf.hansson@linaro.org>
 <1417163403-7070-4-git-send-email-ulf.hansson@linaro.org>
In-Reply-To: <1417163403-7070-4-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Nov 28, 2014 at 9:30 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Instead of using the dev_ops ->stop|start() callbacks for genpd, let's
> convert to use genpd's flag field and set it to GENPD_PM_CLK.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

(tested on r8a7740/armadillo-multiplatform and sh73a0/kzm9g-multiplatform).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
