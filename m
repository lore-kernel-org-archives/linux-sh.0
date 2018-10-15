From: Palmer Dabbelt <palmer@sifive.com>
Date: Mon, 15 Oct 2018 17:39:29 +0000
Subject: Re: [PATCH 5/5] RISC-V: Implement sparsemem
Message-Id: <mhng-d8f1905a-8985-4797-b05b-b165b4ce91f1@palmer-si-x1c4>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <15C8B877-4BBE-47E1-98D1-945E9355E757@raithlin.com>
References: <20181005161642.2462-6-logang@deltatee.com>
In-Reply-To: <20181005161642.2462-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 11 Oct 2018 05:18:20 PDT (-0700), sbates@raithlin.com wrote:
> Palmer
> 
>> I don't really know anything about this, but you're welcome to add a
>>    
>>    Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> 
> Thanks. I think it would be good to get someone who's familiar with linux/mm to take a look.
>     
>> if you think it'll help.  I'm assuming you're targeting a different tree for 
>> the patch set, in which case it's probably best to keep this together with the 
>> rest of it.
> 
> No I think this series should be pulled by the RISC-V maintainer. The other patches in this series just refactor some code and need to be ACK'ed by their ARCH developers but I suspect the series should be pulled into RISC-V. That said since it does touch other arch should it be pulled by mm? 
> 
> BTW note that RISC-V SPARSEMEM support is pretty useful for all manner of things and not just the p2pdma discussed in the cover.

Ah, OK -- I thought this was adding the support everywhere.  Do you mind 
re-sending the patches with the various acks/reviews and I'll put in on 
for-next?

>     
>> Thanks for porting your stuff to RISC-V!
> 
> You bet ;-)
