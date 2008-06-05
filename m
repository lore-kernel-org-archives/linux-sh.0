From: Heiko Schocher <heiko.schocher@invitel.hu>
Date: Thu, 05 Jun 2008 18:04:01 +0000
Subject: Re: Question on SH7763
Message-Id: <48482A91.5060102@invitel.hu>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0806050432i51cb4a38tcedca20496d61131@mail.gmail.com>
In-Reply-To: <29ab51dc0806050432i51cb4a38tcedca20496d61131@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Nobuhiro,

Nobuhiro Iwamatsu wrote:
> Hi,
>
> On Thu, 5 Jun 2008 18:56:49 +0530 (IST)
> pavan_savoy@indiatimes.com wrote:
>
>   
>> Hi,
>>
>> Thank you, I would also like to know, something about the development environment, If I want to write a new flash driver, or new ETH driver, and support them from u-boot, what best would be my environment ?
>>     
> What does environment indicate?
> Is it a compiler?Or, is it OS?
>   

CC ed the u-boot mailinglist, because its more a u-boot topic. I used to
compile the u-boot
for a sh7750R based board (Sorry, patches for u-boot not posted yet ...)
with the
compiler from

http://www.sh-linux.org

There is also a fine readme.txt for installation.

or use crosstools for making a compiler for your needs. See it at:

http://www.kegel.com/crosstool/

And then, hack the code ;-)
If your Flash supports CFI it should work with the CFI driver in u-boot.
Look in the u-boot readme how to start/modify the u-boot code.

bye
Heiko
