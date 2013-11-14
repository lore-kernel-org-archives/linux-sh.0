From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Nov 2013 10:07:12 +0000
Subject: Re: [PATCH] ARM: Kconfig: Mention R-Mobile and R-Car in addition to SH-Mobile
Message-Id: <CANqRtoTXdcjoTVDShoA_071YoNznx88YgLTumdYTviLBaK76=g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384351179-4593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384351179-4593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Laurent,

On Wed, Nov 13, 2013 at 10:59 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> External engineers working on R-Car platforms sometimes can't find
> upstream platform support as the combination of the SH-Mobile name and
> using the product number proved an effective method of concealment. Make
> sure to mention R-Mobile and R-Car in the Kconfig comments and help
> texts.
>
> Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks for your efforts on this. I think this is a good idea, but to
make things a bit more complex I think you should know that r7s72100
is part of the "RZ Family". Also EMEV2 is part of the "Emma" series.

May I propose "Renesas SoC" as a generic description?

Thanks,

/ magnus
