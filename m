From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 06 Apr 2012 03:50:00 +0000
Subject: Re: [PATCH v2] serial: sh-sci: modify sci_break_ctl()
Message-Id: <4F7E67E8.8050402@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F7E3FE2.4050902@renesas.com>
In-Reply-To: <4F7E3FE2.4050902@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2012/04/06 11:44, Simon Horman wrote:
> On Fri, Apr 06, 2012 at 11:13:24AM +0900, Shimoda, Yoshihiro wrote:
>>
>> Thank you for the check.
>> setup-xxxx.c which have "PORT_SCIF" can be tested:
>>  - SH7724, SH7785, R8A7779, etc.
> 
> Thanks, I will try and test on ecovec which I believe has SH7724.

Yes, ecovec has SH7724.

> Do you have any information on how I should test the code,
> other than booting it

If userland calls ioctl with TIOCSBRK/TIOCCBRK, the sci_break_ctl
is called. After TIOCSBRK we cannot send data from SCIF.
After TIOCCBRK, we can send data from SCIF.

Best regards,
Yoshihiro Shimoda
