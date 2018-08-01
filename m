From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 01 Aug 2018 21:55:30 +0000
Subject: Re: [PATCH v2] sh: prefer _THIS_IP_ to current_text_addr
Message-Id: <20180801145530.185dab6b47a61842923fc02d@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <CAKwvOd=DnrfVcuO8Pg=FBrub1M4A8LzarZbtv6m=JO_r6Ea6aQ@mail.gmail.com>
        <20180801185331.39535-1-ndesaulniers@google.com>
In-Reply-To: <20180801185331.39535-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed,  1 Aug 2018 11:53:31 -0700 Nick Desaulniers <ndesaulniers@google.com> wrote:

> As part of the effort to reduce the code duplication between _THIS_IP_
> and current_text_addr(), let's consolidate callers of
> current_text_addr() to use _THIS_IP_.

Why not switch everything to current_text_addr()?  _THIS_IP_ is ugly ;)

Several architectures (s390, sparc, sh, ...) do funky things in their
current_text_addr().  Does the generic kernel.h implementation of
current_text_addr() work OK on those architectures?

