From: Paul Cercueil <pcercuei@gmail.com>
Date: Fri, 25 Nov 2011 16:24:01 +0000
Subject: Re: Dreamcast build broken
Message-Id: <4ECFC121.7070309@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4EC81660.3010109@gmail.com>
In-Reply-To: <4EC81660.3010109@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Le 24/11/2011 08:29, Paul Mundt a =E9crit :
> On Tue, Nov 22, 2011 at 01:02:56PM +0100, Paul Cercueil wrote:
>> Hi,
>>
>> The commit which breaks the dreamcast build is the commit
>> 37b7a97884ba64bf7d403351ac2a9476ab4f1bba :
>> sh: machvec IO death.
>>
> It builds fine for me. You will actually have to supply the build error
> you are experiencing if you expect any further assistance, however.

Hi,

I am able to compile the Linux kernel, the problem is not the compilation.
I do get the "vmlinux" binary once the compilation completes.

However, starting from commit 37b7a97884ba64bf7d403351ac2a9476ab4f1bba=20
and up to the latest vanilla Linux 3.1,
the vmlinux binary won't start on my dreamcast or on the lxdream emulator.
