From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Tue, 03 Jul 2012 11:15:15 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <4FF2D443.4000907@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Mark, Thanks for responding.

(2012/07/03 19:06), Mark Brown wrote:
> On Tue, Jul 03, 2012 at 06:59:30PM +0900, Tetsuyuki Kobayashi wrote:
>
>> +CONFIG_REGULATOR_DUMMY=y
>
> No, this should only ever be enabled as a crutch to get things working.
> It should not be enabled by default.
>
Thank you.
As Guennadi's follow-up, I found this patch is mistake.

