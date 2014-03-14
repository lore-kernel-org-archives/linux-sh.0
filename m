From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 14 Mar 2014 11:10:22 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: koelsch-reference: Work around core clock issues
Message-Id: <5322E39E.5090203@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 14/03/14 11:02, Laurent Pinchart wrote:
> Hi Geert,
>
> Thank you for the patch.
>
> On Thursday 13 March 2014 15:29:30 Geert Uytterhoeven wrote:
>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>>
>> Due to issues with runtime PM clock management, clocks not explicitly
>> managed by their drivers may not be enabled at all, or be inadvertently
>> disabled by the clk_disable_unused() late initcall.
>>
>> Until this is fixed, add a temporary workaround, calling
>> shmobile_clk_workaround() with enable = true.
>>
>> For now this enables the clocks for: ether, i2c2, msiof0, qspi_mod, and
>> thermal. More clocks can be added if needed.
>
> This should do the job, but as you mentioned, it's a crude hack. As we're
> targeting v3.16, is there a chance we could fix the problem properly instead ?

The best fix would be to re-enable the PM and find out what is
actually causing the external abort. However currently there is
no information in the manuals about anything we could find out from
the AXI busses as to what the source actually is.

I have tried updating the CPSR to enable Aborts earlier in the
boot process but so far there's no sign as to what is causing
these issues.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
