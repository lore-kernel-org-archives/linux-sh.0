From: Will Deacon <will.deacon@arm.com>
Date: Thu, 06 Sep 2012 11:21:09 +0000
Subject: Re: [PATCH v3 0/2] ARM: shmobile: enable PMU(Performance Monitoring Unit)
Message-Id: <20120906112109.GG858@mudshark.cambridge.arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <50487370.6000409@kmckk.co.jp>
 <1346930047-9541-1-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1346930047-9541-1-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 06, 2012 at 12:14:05PM +0100, Tetsuyuki Kobayshi wrote:
> From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> 
> Hello, Will

Hi,

Thanks for updating the patches.

> Could you apply this patch set to your pmu/cleanup branch on arm-soc?

Actually, it's better if you just base your branch against that one when you
send it to arm-soc for merging. That way, other SoCs can also develop
against that branch without having to worry about each other.

Cheers,

Will
