From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 29 Sep 2009 07:58:50 +0000
Subject: Re: currect MigoR seems doesn't work
Message-Id: <aec7e5c30909290058r48d7fce3s8ffa9b0a778b7041@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Sep 29, 2009 at 2:59 PM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
>> sh3-linux-objdump -d vmlinux > asm
> zsh: abort =A0 =A0 =A0sh3-linux-objdump -d vmlinux

Last time i checked objdump was broken with dsp instructions.
Disabling dsp support in the kernel should solve the issue short term.

cheers,

/ magnus
