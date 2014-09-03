From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Wed, 03 Sep 2014 02:42:57 +0000
Subject: Re: [PATCH repost] ARM: shmobile: lager: correct memory map
Message-Id: <54068031.5050806@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140903004901.GA3277@verge.net.au>
In-Reply-To: <20140903004901.GA3277@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Dear Simon-san, Shiiba-san,

Thanks for the patch.

On 9/3/2014 9:49 AM, Simon Horman wrote:
> The base address of the second memory region on the lager
> board is 0x140000000. Update the tag used in the dts file accordingly.
> 
> This is a documentation fix and should have no run-time affect.
> 
> This problem was introduced when the second memory region
> was added to the lager dts file by 62bc32a2573c4219
> ("ARM: shmobile: Include all 4 GiB of memory on Lager)"
> in v3.14.
> 
> Reported-by: NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I am reposting this as Olof originally requested a syntax change,
> which I followed up on, however that change no longer seems appropriate.
> This this patch seems to be correct.
[...]
> -	memory@180000000 {
> +	memory@140000000 {

Could you give more information about not using new syntax ?

I checked memblock information in both 2 ways 
(i.e memory@140000000 and memory@1,40000000)
and I got same result.
root@lager:~# cat /sys/kernel/debug/memblock/memory
   0: 0x0000000040000000..0x000000007fffffff
   1: 0x0000000140000000..0x00000001ffffffff

So, what does 'no longer seems appropriate" mean ?

>  		device_type = "memory";
>  		reg = <1 0x40000000 0 0xc0000000>;
>  	};
> 

Thanks.

-- 
Best regards,
KHIEM Nguyen
