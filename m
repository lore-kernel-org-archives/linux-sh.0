From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=  <cm-hiep@jinso.co.jp>
Date: Tue, 22 Oct 2013 00:52:21 +0000
Subject: Re: [PATCH 1/2 v3] ARM: shmobile: r8a7790: add QSPI support
Message-Id: <5265CC45.7000200@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1382326020-10558-2-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1382326020-10558-2-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei

Thanks for your comment,

>>   /* MSTP */
>>   enum {
>> -    MSTP931, MSTP930, MSTP929, MSTP928,
>> +    MSTP931, MSTP930, MSTP929, MSTP928, MSTP917,
>
>    Sorry for not mentioning it before but MSTP917 should be on a line 
> of its own.
>
I am not clear your comment yet. Could you please tell me why the 
MSTP917 should be
on a line of its own instead of MSTP9xx.

Best Regards,

Hiep.

