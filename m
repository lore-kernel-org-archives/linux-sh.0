From: Ed Cashin <ecashin@coraid.com>
Date: Thu, 28 Mar 2013 12:56:35 +0000
Subject: Re: ERROR: "min_low_pfn" [drivers/block/aoe/aoe.ko] undefined!
Message-Id: <A3D99833-2905-4F5A-9FEF-FF2EEE6CBFD1@coraid.com>
List-Id: <linux-sh.vger.kernel.org>
References: <9EA8F092-4957-4A05-9C2C-359F0F133E8C@coraid.com>
In-Reply-To: <9EA8F092-4957-4A05-9C2C-359F0F133E8C@coraid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mar 27, 2013, at 8:58 PM, Fengguang Wu wrote:

> On Wed, Mar 27, 2013 at 06:06:57PM +0000, Ed Cashin wrote:
>> [Cc linux-sh@vger.kernel.org]
>> 
>> Do you think that's from virt_addr_valid, used in aoeblk_open?
> 
> Yes, the error goes away when virt_addr_valid() is removed.

So I'm left thinking this a sh-architecture problem with virt_addr_valid and
its dependencies.

>> I see that when CONFIG_FLATMEM is defined, arch/sh/includ/asm/page.h
>> defines pfn_valid in terms of the undefined variables {min,max}_low_pfn, 
>> and virt_addr_valid in terms of pfn_valid.

-- 
  Ed Cashin
  ecashin@coraid.com


