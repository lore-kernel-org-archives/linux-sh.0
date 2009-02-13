From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Date: Fri, 13 Feb 2009 10:16:00 +0000
Subject: Re: [PATCH] slab: fix slab flags for archs use alignment larger
Message-Id: <4995565D.5010105@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1234461073-23281-1-git-send-email-peppe.cavallaro@st.com>	 <20090212185640.GA6111@linux-sh.org> <499544AD.3030804@st.com>	 <84144f020902130122y471dd92em4a72de43a0cfc681@mail.gmail.com>	 <49954F9A.5020801@st.com> <84144f020902130205x4dc5886l70fe6a695ef050a4@mail.gmail.com>
In-Reply-To: <84144f020902130205x4dc5886l70fe6a695ef050a4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@vger.kernel.org, Christoph Lameter <cl@linux-foundation.org>

Pekka Enberg wrote:
> Hi Giuseppe,
>
> On Fri, Feb 13, 2009 at 12:46 PM, Giuseppe CAVALLARO
> <peppe.cavallaro@st.com> wrote:
>   
>> 1) LOG with my patch:
>> root@linux:~# cat /proc/meminfo | grep Slab
>> Slab:             2612 kB
>>
>> 2) LOG without my patch:
>> root@linux:~# cat /proc/meminfo | grep Slab
>> Slab:             2504 kB
>>     
>
> That's not too bad. I assume it's L1_CACHE_BYTES set to 32 bytes? 
you are perfectly right.
> One big problem with your patch is that on some MIPS configurations
> ARCH_KMALLOC_MINALIGN is as big as 128.
Agree again and problem understood... thanks!
> So if you're going to do this, you can't use ARCH_KMALLOC_MINALIGN directly but add a some
> SLAB_MAX_DEBUG_ALIGN which can be overridden by architecture code.
>   
If you like, I can prepare a patch in any case.
Then we can decide if it actually adds complexity and discard it.
Otherwise we could maintain it.
> One obvious question, though, is whether all this is worth the added
> complexity. I mean, we've managed "just fine" without it for years.
> Paul, thoughts?
>
>                                         Pekka
>
>   

