From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 12 May 2015 08:48:37 +0000
Subject: Re: [PATCH 0/4] r8a7793 pin control support
Message-Id: <CAO3366wADTdEpt8e3XEFNMHLgYN59SMcTcn4-CLABWVQ-te_xA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431015037-25254-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1431015037-25254-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 12, 2015 at 9:31 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Ulrich,
>
> Thank you for the patches.
>
> On Thursday 07 May 2015 18:10:33 Ulrich Hecht wrote:
>> Hi!
>>
>> This is the PFC portion broken out of the previously posted r8a7793 series.
>> Sharing the code of the r8a7791 implementation, it is now about 6000 lines
>> smaller. *cough*
>>
>> The one feature that was missing in the existing r8a7791 PFC implementation
>> is the SSP pin group, which has been moved to a separate patch in this
>> series.
>
> For patches 1 to 3,
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thank you.

> For patch 4, I have the same comment as Geert.

I'll resend this then with the acks and without patch 4.

CU
Uli
