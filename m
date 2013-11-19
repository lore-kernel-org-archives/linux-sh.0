From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Nov 2013 08:16:02 +0000
Subject: Re: [PATCH] sh-pfc: r8a7791: Fix DU pin groups organisation
Message-Id: <CACRpkda_o4-k83KaX445=mwH2ZKLTzpm7=AwOsth5FeKiS-sLg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384346777-888-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384346777-888-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Nov 13, 2013 at 1:46 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Rename the sync_1 group to sync as the device has a single sync pin
> group for the DU, move the cde_disp mux array right after the
> corresponding pins array, and split the clk_in pins in three separate
> groups as the pins can be used independently.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

Patch applied for v3.14.

> The patch is based on top of the latest pinctrl for-next branch and is a
> candidate for v3.14. I've tested it with the DU driver on a Koelsch board.

K=F6lsch! Who names a board after the sweetest dialect in Germany??

Yours,
Linus Walleij
