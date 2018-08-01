From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 01 Aug 2018 22:22:35 +0000
Subject: Re: [PATCH v2] sh: prefer _THIS_IP_ to current_text_addr
Message-Id: <20180801152235.92f2df81e72ef7d0776c24ac@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <CAKwvOd=DnrfVcuO8Pg=FBrub1M4A8LzarZbtv6m=JO_r6Ea6aQ@mail.gmail.com>
        <20180801185331.39535-1-ndesaulniers@google.com>
        <20180801145530.185dab6b47a61842923fc02d@linux-foundation.org>
        <CAKwvOdmHadWqZSLT2DM4D9Kt-EwVHrjuiKy6vYJpVw7Dk=bTKQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmHadWqZSLT2DM4D9Kt-EwVHrjuiKy6vYJpVw7Dk=bTKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, 1 Aug 2018 15:06:33 -0700 Nick Desaulniers <ndesaulniers@google.com> wrote:

> So the plan is to replace the 5 call sites of current_text_addr() with
> _THIS_IP_ (if possible), then delete all definitions of the arch
> specific current_text_addr()'s.  This can be done on a per tree basis,
> rather than a treewide patch for converting _THIS_IP_ (who has many
> more call sites) to current_text_addr().  What do you think?

Sounds good to me.
