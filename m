From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 24 Jan 2014 04:43:12 +0000
Subject: Re: [PATCH V2 1/3] ARM: shmobile: lager: Add USBHS support
Message-Id: <CANqRtoQjqdYOxkb3c5wfyKMgpWORPiPrOk78hrcXa1r+r+S+oQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389982854-20680-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389982854-20680-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jan 18, 2014 at 3:20 AM, Valentine Barshak
<valentine.barshak@cogentembedded.com> wrote:
> This adds USBHS PHY and registers USBHS device if the driver is enabled.
>
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  arch/arm/mach-shmobile/board-lager.c | 138 +++++++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>
> Changes in V2:
> * capitalized ARM in the subject;
> * rebased on top the latest devel tag;
> * added pipe_type array to the usbhs platform info since it differs from the default.

Hi Valentine,

Thanks for this. I have now tested this on my Lager board.

Acked-by: Magnus Damm <damm@opensource.se>

Simon, please queue this up.

I have incremental patches for this that I've cooked up myself. Please
stay tuned.

Valentine, after Simon has merged this then please look into fixing up
Runtime PM for USBHS on r8a7790.

Thanks,

/ magnus
