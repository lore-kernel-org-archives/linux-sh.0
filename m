From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Tue, 18 Sep 2012 04:08:13 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: sh73a0: Select ERRATAs in Kconfig
Message-Id: <5057F3AD.7020200@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1346832708-7369-1-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1346832708-7369-1-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon-san,

(2012/09/18 12:59), Simon Horman wrote:
> On Fri, Sep 07, 2012 at 09:38:35AM +0900, Kuninori Morimoto wrote:
>>
>> Dear Simon, Kobayashi-san
>>
>>>>> SH73a0 SoC has Cortex-A9 core which revision is r2p8.
>>>>> This patch selects ERRATAs for this revision in Kconfig file.
>>>
>>> Magnus, Morimoto-san, do you have an opinion on this?
>>
>> I guess this is first case in our code
>> to use "select" for ERRATA_xxx.
>> We used board defconfig for it.
>
> Hi Kobayashi-san,
>
> would it be possible for you to re-submit this in the
> form of a defconfig patch?
>
OK. I will.

