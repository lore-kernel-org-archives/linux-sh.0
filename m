From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 03 Dec 2013 10:08:14 +0000
Subject: Re: [PATCH 01/11] pinctrl: sh-pfc: r8a7791: fix msiof groups to follow GROUP
Message-Id: <CACRpkdYyLS3gy53GOJhEwYXh4uW_Uxa5PLF1E45OhWvUiMfYpA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
	<1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
In-Reply-To: <1385921962-19843-1-git-send-email-takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Dec 1, 2013 at 7:19 PM,  <takasi-y@ops.dti.ne.jp> wrote:

> From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
>
> SH_PFC_PIN_GROUP(), pins[], mux[], defines
>  clk, sync, ss1, ss2, rx, tx
> But, msiof?_groups[] defines
>  clk, ctrl, data
>
> Fix msiof[012]_groups members to be consistent to PIN_GROUP.
>
> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

This looks all right to me. Laurent is merging PFC patches for this
kernel cycle, please make sure you include him on subsequent
postings. Once Laurent has a finished series I'll pull it into
the pinctrl tree.

I think the device tree changes part of this series can go directly
to Simon though?

Yours,
Linus Walleij
