From: Conrad Parker <conrad@metadecks.org>
Date: Thu, 18 Mar 2010 07:09:51 +0000
Subject: Re: Build error at v2.6.33 of sh-2.6.git
Message-Id: <dba6c0831003180009v4756f9b3s36d695a179620914@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4BA1CB09.8060908@dcl.info.waseda.ac.jp>
In-Reply-To: <4BA1CB09.8060908@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 18 March 2010 16:06, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hi Hitoshi-san,
>
> On Thu, Mar 18, 2010 at 3:41 PM, Hitoshi Mitake
> <mitake@dcl.info.waseda.ac.jp> wrote:
>> So I have a question, is there the de fact standard of corss compiler
>> building kit for SuperH arch?
>> If there is, could you tell me?
>
> I used to build cross compilers all the time. These days I use the
> binary distribution provided by codesourcery.
>
> http://www.codesourcery.com/sgpp/editions.html
>
> Not sure about the status of upstream gcc, binutils and gdb. If the
> specific version of gcc that you are building with fails, please make
> sure to upgrade to the latest version and try again. I've also heard
> that debian should build fine on sh4, so I guess they have whatever
> patches that are needed.

info on the debian packages is here::

http://wiki.debian.org/SH4

cheers,

Conrad.
