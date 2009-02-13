From: Pekka Enberg <penberg@cs.helsinki.fi>
Date: Fri, 13 Feb 2009 09:30:34 +0000
Subject: Re: [PATCH] slab: fix slab flags for archs use alignment larger
Message-Id: <84144f020902130130k7d66bd0i7637ec0589d3bee1@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1234461073-23281-1-git-send-email-peppe.cavallaro@st.com>
	 <20090212185640.GA6111@linux-sh.org> <499544AD.3030804@st.com>
	 <84144f020902130122y471dd92em4a72de43a0cfc681@mail.gmail.com>
In-Reply-To: <84144f020902130122y471dd92em4a72de43a0cfc681@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Christoph Lameter <cl@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>

On Fri, Feb 13, 2009 at 11:22 AM, Pekka Enberg <penberg@cs.helsinki.fi> wro=
te:
> That sounds unfortunate. Can you post
>
> =A0cat /proc/meminfo | grep Slab
>
> results on sh without and with your patch? Bumping the limit up to
> ARCH_KMALLOC_MINALIGN does make sense but we'd need to know what kind
> of problems it might cause.

You probably want to fix up the issues Paul raised, though.
