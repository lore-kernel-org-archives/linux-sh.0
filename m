From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 20 Dec 2013 07:18:39 +0000
Subject: Re: [PATCH v6 15.1/17] ARM: shmobile: Add GPIO keys to Koelsch DTS
Message-Id: <CANqRtoRTLzzxqAit6eg46-NJKqb9eU6OW5ZTV9X3KkWYQ1=Jwg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387466923-8800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387466923-8800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 20, 2013 at 12:28 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The Koelsh reference device tree is going away, copy the missing GPIO
> keys device node to the Koeslch device tree file.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 54 +++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> Hi Simon,
>
> This patch contains the differences between v4 (which you have queued up) and
> v5 of "ARM: shmobile: Sync Koelsch DTS with Koelsch reference DTS". Feel free
> to apply it on top of your dt branch, or alternatively rebase the branch to
> replace v4 with v5.

Hi Laurent,

Thanks for this patch. If you compare GPIO-keys on Koelsch and Lager
then you can see that both have a DIP switch and Koelsch also has a
set of buttons. I may recall wrong, but I think the legacy code
supports both the DIP switch and buttons. This DT reference patch
seems to only add buttons, not the DIP switch. Any plans to include
the DIP switch?

Cheers,

/ magnus
