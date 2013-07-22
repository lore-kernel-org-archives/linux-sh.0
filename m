From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 22 Jul 2013 19:09:53 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: fix SDHI0 VccQ regulator on sh73a0 with DT
Message-Id: <CACRpkdYUWJdU01U2W+FWSTuwcPKqu2mvRjtTi4YAMUT9gS9HEw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307091625490.28812@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307091625490.28812@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 9, 2013 at 4:27 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:

> The PFC pinctrl driver on sh73a0 is also regiatering a VccQ regulator for
> SDHI0. However, its consumers list only included the platform-data based
> SDHI device name. When booted with DT SDHI0 couldn't enable VccQ and
> therefore was unusable. Fix this by adding a consumer with DT-based name.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Patch applied with Simon's and Laurent's ACKs.

Yours,
Linus Walleij
