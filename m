From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 27 Jun 2014 04:52:48 +0000
Subject: Re: [PATCH RFC 3/3] spi: rspi: Add support for new R-Car Gen2 SoCs
Message-Id: <CANqRtoT8T4nin3JSPxy0G+BR_LWhmOtA2AeGh-yAi-m1h+gmHg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401198311-21268-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1401198311-21268-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thu, Jun 26, 2014 at 6:31 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, May 27, 2014 at 3:45 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> Add support for QSPI in:
>>   - r8a7792 (R-Car V2H)
>>   - r8a7793 (R-Car M2-N)
>>   - r8a7794 (R-Car E2)
>>
>> r8a7791 is now called "R-Car M2-W".
>
> Has anyone tried this on one of the new SoCs?

Thanks for extending the compatible strings.

I'm not aware of anyone trying it out. I think r8a7794 is not that far
away though.

Cheers,

/ magnus
