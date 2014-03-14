From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 14 Mar 2014 17:33:25 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: koelsch-reference: Work around core clock issues
Message-Id: <53233D65.4050703@codethink.co.uk>
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
> That would not surprise me. But it would trigger both for
> multiplatform and legacy in such case, don't you think?
>
> If static enablement using the clock workaround fixes the
> multiplatform case then it is most likely related to that the driver
> assumes that Runtime PM controls the clock. Or perhaps some hidden
> clock dependency that only triggers with CCF?

It seems very sensitive to code (or possibly compiler) in some but
not all cases we are seeing the system pm the device and then the
driver does something that requires clocks.

At the moment the depending on how much debug it either works, or
does not.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
