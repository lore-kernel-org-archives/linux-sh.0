From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 09 Dec 2015 17:16:58 +0000
Subject: Re: [PATCH v2 6/6] arm64: renesas: r8a7795: Add L2 cache-controller nodes
Message-Id: <5668620A.9070908@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
 <1449512659-16688-7-git-send-email-geert+renesas@glider.be>
 <5665D4C7.1050705@arm.com> <20151207190355.GE28024@leverpostej>
 <5667267E.2080601@gmail.com> <20151208191656.GD11797@leverpostej>
 <56685DBE.8030001@gmail.com>
In-Reply-To: <56685DBE.8030001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org



On 09/12/15 16:58, Dirk Behme wrote:
> On 08.12.2015 20:16, Mark Rutland wrote:

[...]

>>
>> With the other properties from ePAPR you can acquire information on the
>> geometry of the cache, which cannot be acquired from architected
>> registers.
>
>
> Just for my understanding: Yes, if other properties from ePAPR like
> geometry of the cache are added to the device tree l2 cache entries then
> it makes sense to have them.
>
> But an "empty" entry like the one given in the example above doesn't
> make much sense and could be removed without loosing any functionality?
>

No they are required to detect the cache hierarchy as there's no
architectural way of detecting the same.

> It looks to me that most of the L2 entries we have in
> arch/arm64/boot/dts are such "empty" entries.
>

True *so far*, we have not seen a case where we need to override the
values read in a architectural way.

-- 
Regards,
Sudeep
