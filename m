From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Oct 2013 09:01:40 +0000
Subject: Re: [PATCH 2/6] arm: shmobile: lager: Add USBHS support
Message-Id: <CANqRtoTSqSBLTpr0V4yxurwP3C7nxO_hygr4u6qvKfHGVy6y1w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

On Thu, Oct 3, 2013 at 7:52 AM, Valentine
<valentine.barshak@cogentembedded.com> wrote:
> On 10/02/2013 04:18 AM, Magnus Damm wrote:
>> Have you considered putting these SoC specific bits into drivers/usb/...
>
> I'll try to add device id table and move it to renesas_usbhs driver.

Sounds good, thank you!

> Hope the "renesas_usbhs_rcar_h2" device name is not too long.

Please use SoC model string "r8a7790" for DT like other drivers, as an
example see the following commit:

commit df1d0584b2292df5b9d576d7e5246e94616220a1
Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date:   Thu Aug 29 17:14:49 2013 +0200

    ARM: shmobile: update SDHI DT compatibility string to the
<unit>-<soc> format

Cheers,

/ magnus
