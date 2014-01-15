From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Jan 2014 12:39:07 +0000
Subject: Re: [PATCH 1/3] arm: shmobile: lager: Add USBHS support
Message-Id: <CANqRtoSCppvquKsrCzLS7ewrR3yRthpdXfwua6RbKcR=HRNi=g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387548804-20829-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387548804-20829-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 20, 2013 at 11:13 PM, Valentine Barshak
<valentine.barshak@cogentembedded.com> wrote:
> This adds USBHS PHY and registers USBHS device if the driver is enabled.
>
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  arch/arm/mach-shmobile/board-lager.c | 117 +++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)

Hi Valentine,

Thanks for this USB function patch. I'd like to switch focus to USB
function soon.

By the way, I'm happy to see that SATA platform device support is
picked up by Simon. I intend to give your SATA DTS patches a go later
this week, they should be ready to queue up rather soon I believe.

Would it be possible for you to update your USB function platform
device patches for Lager and Koelsch? I'd like to merge those after
SATA, and the platform device files shouldn't change now so USB can go
next now unless I'm mistaken. Please send a complete per-board series
for USB function so patch pick up and testing gets easy - same style
as SATA would be great.

I suppose we need to control MSTP bits via Runtime PM for USBHS, so
some patch for clock control may be needed as well.

Thanks,

/ magnus
