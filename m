From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 14 Mar 2014 17:11:12 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: koelsch-reference: Work around core clock issues
Message-Id: <53233830.5000405@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 14/03/14 16:48, Magnus Damm wrote:
> Hi Ben,
>

>> I did post an updated to ensure the MDIO bus is accessed with clock
>> enabled, but that has not cured the issue for me. I wonder if some
>> other part of the driver is also accessing the hardware without
>> the correct pm accesses.
>
> That would not surprise me. But it would trigger both for
> multiplatform and legacy in such case, don't you think?
>
> If static enablement using the clock workaround fixes the
> multiplatform case then it is most likely related to that the driver
> assumes that Runtime PM controls the clock. Or perhaps some hidden
> clock dependency that only triggers with CCF?

I am not quite sure what is going on here. So far I am down to the
pm_runtime_enable(&pdev->dev) call setting the clock on and then the
pm_runtime_resume(&pdev->dev) call after it immediately shutting the
clock down!

I added code to do a WARN_ON(!__clk_is_enabled) on the read/write
calls and it has been triggering quite a bit.

> Thanks,
>
> / magnus
>


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
