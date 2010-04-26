From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Date: Mon, 26 Apr 2010 10:52:00 +0000
Subject: Re: Hi guys, does any of you have experience with touchscreen controllers?
Message-Id: <4BD57050.3070402@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
References: <201004222004.38724.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004222004.38724.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi

Fabio Giovagnini wrote:
> Thanks a lot.
> But where is a good example for starting from?
>
> Thanks
>  =20
http://www.avrfreaks.net/index.php?name=3DPNphpBB2&file=3Dviewtopic&ty646

You can find here an example :)

Michael
>
>
> In data luned=EC 26 aprile 2010 12:41:13, Michael Trimarchi ha scritto:
> : > hi fabio,
>  =20
>> Fabio Giovagnini wrote:
>>    =20
>>> Hi Dale,
>>> maybe I need to be more clear about my condition.
>>> 1) I connected the ads7843 to general I/O ports because the SPIs
>>> available on sh2a7203 have been be used for other functions;
>>>      =20
>> It is not a big problem, you can also bitbang on the gpio pin.
>>
>>    =20
>>> 2) My real problem is the following: I wrote an ADS7843 device driver as
>>> a button driver of the input subsystem. I configured the ads7843 with I=
NT
>>> enabled; so when the touch is pressed I have a burst of IRQ. The IRQ
>>> handler read the ads7843 and return to the input subsystem the abs valu=
es
>>> of the touchscreen.
>>>      =20
>> I think tha rewrite the code it is not so usefull but reuse the code
>> using a bitbang interface
>> it's more simple and don't need a lot of testing
>>
>> Michael Trimarchi
>>
>>    =20
>
>  =20

