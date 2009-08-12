From: "Nylund, Martin" <Martin.Nylund@emtrion.de>
Date: Wed, 12 Aug 2009 07:34:26 +0000
Subject: AW: kernel oopses on 7780 target with 2.6.25 kernel
Message-Id: <37C9A1F7C45F1F498E9CB8295E7B305CBD3FE9@em-srv1-kaha.intern.emtrion.de>
List-Id: <linux-sh.vger.kernel.org>
References: <37C9A1F7C45F1F498E9CB8295E7B305CBD3FE6@em-srv1-kaha.intern.emtrion.de>
In-Reply-To: <37C9A1F7C45F1F498E9CB8295E7B305CBD3FE6@em-srv1-kaha.intern.emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


> in 2.6.30 
> set_pte(kmap_coherent_pte - (FIX_CMAP_END - idx), pte);
> is called after update_mmu_cache.
> 
> So, you should better to update to the recent kernel.

I was afraid of something like that. Do you happen to remember when or
in which kernel release this bug was fixed? Is it a total no-go to try
to backport this to 2.6.25? Updating the whole kernel takes time which I
currently don't have.

regards,
Martin
