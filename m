From: Valentine <valentine.barshak@cogentembedded.com>
Date: Fri, 04 Oct 2013 00:30:43 +0000
Subject: Re: [PATCH 2/6] arm: shmobile: lager: Add USBHS support
Message-Id: <524E0C33.4090606@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/04/2013 04:21 AM, Kuninori Morimoto wrote:
>
> Hi Laurent
>
> Thank you for your response
>
>> The problem with such a mechanism is that it only works with platform data, as
>> we don't have callback functions in DT.
>
> Yes, I agree.
>
> But in renesas_usbh case, almost all Renesas USBHS chip needs
> its own special initializing method.
> And somechip depends on SoC, somechip depends on platform.
>
> I'm not sure formal/correct DT solution in this case,
> but, I thought we can add data table on of_platform_populate().
>
> # BTW, I need to know how to solve FPGA special settings on DT...
>
> Best regards
> ---
> Kuninori Morimoto
>

I think we need a USB phy driver here.
The one that should be acquired by both renesas_usbhs and PCI USB.
I'm currently experimenting with it.

I believe that all the phy handling should be moved to the phy drivers 
eventually when we switch to using DT,

Thanks,
Val.
