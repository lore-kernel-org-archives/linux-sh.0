From: mahdi hamzeh <mahdy.hamzeh@gmail.com>
Date: Mon, 24 Jan 2011 23:04:57 +0000
Subject: DMA
Message-Id: <AANLkTimiLJz-F3QMppVjh9ZaF8JbGeRawPgNme1dWjVJ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,
I am working on a research project for which I should be able to
transfer data from memory to memory using DMA. I am working on a x86
machine but I want my code to be architecture independent as much as
possible. Please=A0accept=A0my=A0apology=A0if my question is too basic to be
asked from this mailing list. Here is my problem:
I=A0used "struct dma_chan" to define a channel structure but when I use
"dma_request_channel" function to get a DMA channel, with all
different possible masks including=A0DMA_MEMCPY,=A0DMA_PRIVATE,....
anything, the function returns always NULL. This function is defined
in "dmaengine.h".=A0I also tried a low level function to see dma channel
availability=A0and "request_dma" function defined in "dma.h" works
perfect.
Any comment, help, document, program, reference anything that helps me
to create a simple DMA transaction would really be appreciated.
PS: There is a test program called dmatest.c is provided in the linux
kernel files. I tried to get it compiled but I could not since the
functions and structures used in this file has been changed in the
kernel header files.

Thanks
--
---Mahdi Hamzeh
