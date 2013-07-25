From: Katsuya MATSUBARA <matsu@igel.co.jp>
Date: Thu, 25 Jul 2013 07:32:56 +0000
Subject: Re: [PATCH] ml86v7667: override default field interlace order
Message-Id: <20130725.163256.373541261.matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <201307152312.22371.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201307152312.22371.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: mchehab@redhat.com, linux-media@vger.kernel.org, hverkuil@xs4all.nl, linux-sh@vger.kernel.org, vladimir.barinov@cogentembedded.com


 Hi Vladimir,

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] ml86v7667: override default field interlace order
Date: Mon, 15 Jul 2013 23:12:21 +0400

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> ML86V7667 always transmits top field first for both PAL and  NTSC -- that makes
> application incorrectly  treat interlaced  fields when relying on the standard.
> Hence we must set V4L2_FIELD_INTERLACED_TB format explicitly.
> 
> Reported-by: Katsuya MATSUBARA <matsu@igel.co.jp>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: added a comment.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
(snip)

I made sure that it works well on the Renesas BOCK-W board.

Tested-by: Katsuya MATSUBARA <matsu@igel.co.jp>

---
Katsuya Matsubara / IGEL Co., Ltd
matsu@igel.co.jp
