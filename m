From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=  <cm-hiep@jinso.co.jp>
Date: Tue, 22 Oct 2013 01:55:17 +0000
Subject: Re: [PATCH 1/2 v3] ARM: shmobile: r8a7790: add QSPI support
Message-Id: <5265DB05.5000009@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1382326020-10558-2-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1382326020-10558-2-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san

>>>>    /* MSTP */
>>>>    enum {
>>>> -    MSTP931, MSTP930, MSTP929, MSTP928,
>>>> +    MSTP931, MSTP930, MSTP929, MSTP928, MSTP917,
>>>     Sorry for not mentioning it before but MSTP917 should be on a line
>>> of its own.
>>>
>> I am not clear your comment yet. Could you please tell me why the
>> MSTP917 should be
>> on a line of its own instead of MSTP9xx.
> It is SH-ARM traditional rule.
> MSTP line should keep like this
>
>   MSTP93x, MSTP93y, MSTP93z...
>   MSTP92x, MSTP92y, MSTP92z...
>   MSTP91x, MSTP91y, MSTP91z...
>
> But, as I already commented, current MSTP9xx line is already broken here.
> # The SoC which has broken MSTP line is not only r8a7790 today,
> # and cleaning these line makes it difficult to backport.
>
> Anyway, sending v4 patch for it is up to Simon.
Thanks, I'll update the patch v4 with Sergei's and your comments to Simon.

Best Regards,
---
Hiep Cao Minh.


