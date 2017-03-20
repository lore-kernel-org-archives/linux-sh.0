From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 20 Mar 2017 13:54:43 +0000
Subject: Re: [PATCH 4/6] sh: Use full path in KBUILD_IMAGE definition
Message-Id: <CAK7LNATZMNLe6zwhAcfj=F3+jEBYYXV3VKzpL5++puevziS8cQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20161122213434.14788-1-mmarek@suse.com> <20161122213434.14788-4-mmarek@suse.com>
In-Reply-To: <20161122213434.14788-4-mmarek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Marek <mmarek@suse.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

2016-11-23 6:34 GMT+09:00 Michal Marek <mmarek@suse.com>:
> The KBUILD_IMAGE variable is used by the rpm and deb-pkg targets, which
> expect it to point to the image file in the build directory. The
> builddeb script has a workaround for architectures which only provide
> the basename, but let's provide a clean interface for packaging tools.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Michal Marek <mmarek@suse.com>



Applied to linux-kbuild/misc.  Thanks!



-- 
Best Regards
Masahiro Yamada
