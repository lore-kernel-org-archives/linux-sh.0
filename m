From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 27 Jul 2013 22:20:48 +0000
Subject: Re: [PATCH] ml86v7667: override default field interlace order
Message-Id: <51F447C0.9030901@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201307152312.22371.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201307152312.22371.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mchehab@samsung.com, linux-media@vger.kernel.org, hverkuil@xs4all.nl
Cc: matsu@igel.co.jp, linux-sh@vger.kernel.org, vladimir.barinov@cogentembedded.com

Hello.

On 15.07.2013 23:12, I wrote:

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

> ML86V7667 always transmits top field first for both PAL and  NTSC -- that makes
> application incorrectly  treat interlaced  fields when relying on the standard.
> Hence we must set V4L2_FIELD_INTERLACED_TB format explicitly.

> Reported-by: Katsuya MATSUBARA <matsu@igel.co.jp>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: added a comment.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> This patch is against the 'media_tree.git' repo.

    I forgot to mention that it was against the 'fixes' branch, and we 
intended it as a fix (I'm seeing this patch committed to the 'master' branch).

WBR, Sergei

