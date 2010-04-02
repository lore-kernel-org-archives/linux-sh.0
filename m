From: Conrad Parker <conrad@metadecks.org>
Date: Fri, 02 Apr 2010 02:35:05 +0000
Subject: Re: O_DIRECT not found.
Message-Id: <l2udba6c0831004011935w2cde4148j9f7350430c5681a0@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201004011815.12072.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004011815.12072.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 2 April 2010 01:15, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <stdio.h> /* Standard input/output definitions */
> #include <string.h> /* String function definitions */
> #include <unistd.h> /* UNIX standard function definitions */
> #include <fcntl.h> /* File control definitions */
> #include <errno.h> /* Error number definitions */
> #include <termios.h>
>
> .
> .
> .
>
>
>
> rs485TxEn_fd = open("/proc/mlcdports/rs485txen",O_WRONLY | O_NDELAY |
> O_DIRECT);
>
> .
> .
> .
>
> Why I cannot find the flag O_DIRECT

You'd need to #define _GNU_SOURCE before including <fcntl.h>

from open(2):

 O_DIRECT is not specified in POSIX; one has to define _GNU_SOURCE to  get
 its definition.

Conrad.
