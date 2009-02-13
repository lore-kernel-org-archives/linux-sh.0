From: Pekka Enberg <penberg@cs.helsinki.fi>
Date: Fri, 13 Feb 2009 10:05:43 +0000
Subject: Re: [PATCH] slab: fix slab flags for archs use alignment larger
Message-Id: <84144f020902130205x4dc5886l70fe6a695ef050a4@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1234461073-23281-1-git-send-email-peppe.cavallaro@st.com>
	 <20090212185640.GA6111@linux-sh.org> <499544AD.3030804@st.com>
	 <84144f020902130122y471dd92em4a72de43a0cfc681@mail.gmail.com>
	 <49954F9A.5020801@st.com>
In-Reply-To: <49954F9A.5020801@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@vger.kernel.org, Christoph Lameter <cl@linux-foundation.org>

Hi Giuseppe,

On Fri, Feb 13, 2009 at 12:46 PM, Giuseppe CAVALLARO
<peppe.cavallaro@st.com> wrote:
> 1) LOG with my patch:
> root@linux:~# cat /proc/meminfo | grep Slab
> Slab: =A0 =A0 =A0 =A0 =A0 =A0 2612 kB
>
> 2) LOG without my patch:
> root@linux:~# cat /proc/meminfo | grep Slab
> Slab: =A0 =A0 =A0 =A0 =A0 =A0 2504 kB

That's not too bad. I assume it's L1_CACHE_BYTES set to 32 bytes? One
big problem with your patch is that on some MIPS configurations
ARCH_KMALLOC_MINALIGN is as big as 128. So if you're going to do this,
you can't use ARCH_KMALLOC_MINALIGN directly but add a some
SLAB_MAX_DEBUG_ALIGN which can be overridden by architecture code.

One obvious question, though, is whether all this is worth the added
complexity. I mean, we've managed "just fine" without it for years.
Paul, thoughts?

                                        Pekka
