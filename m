From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Fri, 03 Oct 2014 03:25:34 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: switch from scif to scifa
Message-Id: <542E172E.1060007@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On 10/3/2014 9:13 AM, Wolfram Sang wrote:
> Hello,
> 
>> Which datasheet you are mentioned about ?
>> I checked Lager board datasheet rev0.09 and it said debug interface is SCIF0 and SCIF1.
> 
> V0.12D. On Page 22, the headline says "Debug Interface (SCIF0)", true.
> However, the wires are named SCIFA0_TXD/RXD. Same for SCIF(A)1. On Page
> 2, as well. Check Y30 and AA29, they are named SCIFA0/A1.

I think you got the information from circuit diagram of Lager board.
However, I got my information from Hardware manual of Lager board.

I also checked circuit diagram and see the mismatch
between circuit diagram and hardware manual.

I'm confirming with related persons.
Will let you know the update soon.

> Kind regards,
> 
>    Wolfram
> 

-- 
Best regards,
KHIEM Nguyen
