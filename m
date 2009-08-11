From: SUGIOKA Toshinobu <sugioka@itonet.co.jp>
Date: Tue, 11 Aug 2009 15:33:17 +0000
Subject: Re: kernel oopses on 7780 target with 2.6.25 kernel
Message-Id: <4.2.0.58.J.20090811235635.041f0be8@router.itonet.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <37C9A1F7C45F1F498E9CB8295E7B305CBD3FE6@em-srv1-kaha.intern.emtrion.de>
In-Reply-To: <37C9A1F7C45F1F498E9CB8295E7B305CBD3FE6@em-srv1-kaha.intern.emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

At 15:00 09/08/11 +0200, "Nylund, Martin" <Martin.Nylund@emtrion.de> wrote:
>I have a SH7780 target with kernel 2.6.25. I get some strange memory
>management related kernel OOPSes when running a simple kernel module
>which just acknowledges a interrupt source. Here's my module:

kmap_coherent in 2.6.25 has a bug.
Temporal TLB entry created in kmap_coherent is not registered to swapper_pg_dir.
So, if that entry is replaced, it can't be reloaded.
The scenario might be,
 (1) TLB is loaded in kmap_coherent by "update_mmu_cache".
 (2) Interrupt.
 (3) Interrupt handler cause TLB miss.
 (4) TLB entry which is loaded in step (1) is replaced.
 (5) copy_from/to_user_page get TLB miss, but fault handler can't find entry
     in the page directory.

in 2.6.30 
set_pte(kmap_coherent_pte - (FIX_CMAP_END - idx), pte);
is called after update_mmu_cache.

So, you should better to update to the recent kernel.

Regards,
  SUGIOKA Toshinobu.
