From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 May 2013 07:36:59 +0000
Subject: Re: [PATCH v2 1/2] pinctrl: sh-pfc: fix r8a7790 Function Select register tables
Message-Id: <CACRpkdaYww0ERgHy8-qxLJ34P-jHQ8gfkMy3Rz3Tnj6UaeKubA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1305151238040.10596@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1305151238040.10596@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 15, 2013 at 12:46 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:

> Fix several errors in Peripheral Function Select register tables for
> r8a7790, which prevent various function pins from being correctly
> configured.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>
> v2: fix a fixed bit-count, thanks to Laurent for catching

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I was a bit confused first and tried to apply this for v3.10 fixes,
but it appears this is for the v3.11 stuff queued in Simon's tree
right?

Yours,
Linus Walleij
