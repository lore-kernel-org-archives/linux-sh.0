From: Pekka Enberg <penberg@cs.helsinki.fi>
Date: Fri, 13 Feb 2009 09:22:58 +0000
Subject: Re: [PATCH] slab: fix slab flags for archs use alignment larger
Message-Id: <84144f020902130122y471dd92em4a72de43a0cfc681@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1234461073-23281-1-git-send-email-peppe.cavallaro@st.com>
	 <20090212185640.GA6111@linux-sh.org> <499544AD.3030804@st.com>
In-Reply-To: <499544AD.3030804@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@vger.kernel.org, Christoph Lameter <cl@linux-foundation.org>

Hi Giuseppe,

On Fri, Feb 13, 2009 at 12:00 PM, Giuseppe CAVALLARO
<peppe.cavallaro@st.com> wrote:
> IIUC, and as you explained above, ralign is already set to the cache
> line size by the following code:
> ...
> /* 3) caller mandated alignment */
> if (ralign < align)
> ralign = align;
>
> Then, there is following check:
> ...
> /* disable debug if necessary */
> if (ralign > _alignof__(unsigned long long))
> flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
>
> In my point of view, just this check appears "incoherent" (please, note
> I'm not familiar with the slab internals).
> It always makes sense in case of x86 where ARCH_KMALLOC_MINALIGN is
> defined as: __alignof__(unsigned long long) as well.

The code is indeed quite cryptic but I don't think the above statement
is correct. Both SLAB_RED_ZONE and SLAB_STORE_USER add padding in
front of an object and the maximum size of that padding is 2 *
sizeof(unsigned long long). That's why we check for
__alignof__(unsigned long) there to make sure the object can begin
immediately after the padding added for red-zone and user pointer.

On Fri, Feb 13, 2009 at 12:00 PM, Giuseppe CAVALLARO
<peppe.cavallaro@st.com> wrote:
> In case of sh, we always disable debug for 32 aligned objects. As side
> effect, within the leaks_show function we immediately exit for them.
> Indeed, after applying the patch, I attached, I was able to find size-X
> fields within the slab_allocators proc entry.

That sounds unfortunate. Can you post

  cat /proc/meminfo | grep Slab

results on sh without and with your patch? Bumping the limit up to
ARCH_KMALLOC_MINALIGN does make sense but we'd need to know what kind
of problems it might cause.

                                Pekka
