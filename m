From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Feb 2014 07:41:43 +0000
Subject: Re: [PATCH V3 2/4] ARM: shmobile: koelsch: Add USBHS support
Message-Id: <CANqRtoQC9=DBO1vukkJrcMg8Lw8qVeMZCcZOKK-1iPvMrENRQA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

On Sat, Jan 25, 2014 at 7:29 AM, Valentine Barshak
<valentine.barshak@cogentembedded.com> wrote:
> This adds USBHS PHY and registers USBHS device if the driver is enabled.
>
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  arch/arm/mach-shmobile/board-koelsch.c | 138 +++++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>
> Changes in V3:
> * none.
>
> Changes in V2:
> * capitalized ARM in the subject;
> * rebased on top the latest devel tag;
> * added pipe_type array to the usbhs platform info since it differs from the default.

Thanks for your patch. I'd like to fix up USBHS support on Koelsch,
but judging by the schematics there is a MAX3355E mounted on Koelsch
as U42 which is connected to CN6 and USB0. This patch does not seem to
take that into consideration.

Would it be possible for you to add support to the Koelsch board code
to handle the MAX3355E signals as GPIO? I believe the USBHS can be
used in Host mode too, so no need to try to enable the PCI USB on
USB0. I think we can follow Lager and keep USB0 fixed to USBHS, but in
Koelsch case since the MAX3355E allows cable detection via the ID pin
we don't need any special gadget-only workaround.

Also, no need to be specia, so please remove #ifdefs. =)

I'd be happy to set up a chat meeting with you to discuss this in more
detail if needed. Let me know if so.

Thanks,

/ magnus
