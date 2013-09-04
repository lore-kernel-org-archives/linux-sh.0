From: Ian Molton <ian.molton@codethink.co.uk>
Date: Wed, 04 Sep 2013 08:54:13 +0000
Subject: Re: [PATCH 2/2] SPI: EMMA Mobile SPI master driver
Message-Id: <5226F535.2000804@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1378227303-18795-2-git-send-email-ian.molton@codethink.co.uk>
In-Reply-To: <1378227303-18795-2-git-send-email-ian.molton@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 04/09/13 09:45, Ben Dooks wrote:
> On 03/09/13 17:55, Ian Molton wrote:
>> This patch provides support for the EMMA mobile SPI master controller.
>>
>> At present, only PIO mode is supported, and unless GPIOs are used for
>> chipselect, transfers are limited to 4 bytes maximum.
>>
>> RW transfers are not supported, and only 8 bit words are supported at 
>> present.
>
> you forgot to sign your work.

Because its not yet *quite* ready for production... probably should have 
written RFC but yeah :)

I'm fairly happy for it to be accepted, but it is missing a few 
features. If thats ok, I'll resubmit a signed off copy.

-Ian

