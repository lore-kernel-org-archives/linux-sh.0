From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 11 Sep 2015 09:12:18 +0000
Subject: Re: [PATCH 2/2] i2c-tools: i2ctransfer: clean up allocated resources
Message-Id: <20150911111218.319b0c23@endymion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <1434710432-4182-1-git-send-email-wsa@the-dreams.de>
	<1434710432-4182-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1434710432-4182-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

Hi Wolfram,

On Fri, 19 Jun 2015 12:40:32 +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> I still think this makes the code less readable and unnecessarily big [1],
> but I assume Jean insists on it :) So, here is an add-on patch to squash.

Oh yeah. I'd also love if you could close the i2c device file before
leaving, even in error cases ;-)

>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> [1] http://www.gnu.org/software/libc/manual/html_node/Freeing-after-Mallo=
c.html#Freeing-after-Malloc
>=20
> "There is no point in freeing blocks at the end of a program, because
> all of the program=E2=80=99s space is given back to the system when the p=
rocess
> terminates."

Yeah, like the GNU folks are right on everything. Just see their
recommended coding style... :D

I know that the memory would be freed anyway. But I think there is
value in consistency. Also freeing the memory documents the memory
allocation model as a nice side effect. And avoids bad surprises when
one copies code from a command line tool to a GUI tool or a daemon. And
it lets you run the code under valgrind.

So I see the cost but I still believe that the benefits outweigh that
cost.

> ---
>  tools/i2ctransfer.c | 44 +++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
>=20
> diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
> index 27f4d7a..418e303 100644
> --- a/tools/i2ctransfer.c
> +++ b/tools/i2ctransfer.c
> @@ -127,7 +127,7 @@ int main(int argc, char *argv[])
>  {
>  	char filename[20];
>  	char *end;
> -	int i2cbus, address =3D -1, file, arg_idx =3D 1, nmsgs =3D 0, nmsgs_sen=
t;
> +	int i2cbus, address =3D -1, file, arg_idx =3D 1, nmsgs =3D 0, nmsgs_sen=
t, i;
>  	int force =3D 0, yes =3D 0, version =3D 0, verbose =3D 0;
>  	unsigned buf_idx =3D 0;
>  	unsigned long len, raw_data;
> @@ -138,6 +138,9 @@ int main(int argc, char *argv[])
>  	struct i2c_rdwr_ioctl_data rdwr;
>  	enum parse_state state =3D PARSE_GET_DESC;
> =20
> +	for (i =3D 0; i < I2C_RDRW_IOCTL_MAX_MSGS; i++)
> +		msgs[i].buf =3D NULL;
> +

If you explicitly set "buf =3D NULL" for zero-length messages in the
state machine as recommended in my review of the previous patch, this
is no longer needed.

>  	/* handle (optional) arg_idx first */
>  	while (arg_idx < argc && argv[arg_idx][0] =3D '-') {
>  		switch (argv[arg_idx][1]) {
> @@ -178,7 +181,7 @@ int main(int argc, char *argv[])
>  		if (nmsgs > I2C_RDRW_IOCTL_MAX_MSGS) {
>  			fprintf(stderr, "Error: Too many messages (max: %d)\n",
>  				I2C_RDRW_IOCTL_MAX_MSGS);
> -			exit(1);
> +			goto err_out;
>  		}
> =20
>  		switch (state) {
> @@ -190,20 +193,20 @@ int main(int argc, char *argv[])
>  			case 'w': break;
>  			default:
>  				fprintf(stderr, "Error: Invalid direction\n");
> -				goto err_out;
> +				goto err_out_with_arg;
>  			}
> =20
>  			len =3D strtoul(arg_ptr, &end, 0);
>  			if (len > 65535) {
>  				fprintf(stderr, "Error: Length invalid\n");
> -				goto err_out;
> +				goto err_out_with_arg;
>  			}
> =20
>  			arg_ptr =3D end;
>  			if (*arg_ptr) {
>  				if (*arg_ptr++ !=3D '@') {
>  					fprintf(stderr, "Error: No '@' after length\n");
> -					goto err_out;
> +					goto err_out_with_arg;
>  				}
> =20
>  				/* We skip 10-bit support for now. If we want it, it
> @@ -213,16 +216,16 @@ int main(int argc, char *argv[])
> =20
>  				address =3D parse_i2c_address(arg_ptr);
>  				if (address < 0)
> -					goto err_out;
> +					goto err_out_with_arg;
> =20
>  				if (!force && set_slave_addr(file, address, 0))
> -					goto err_out;
> +					goto err_out_with_arg;
> =20
>  			} else {
>  				/* Reuse last address if possible */
>  				if (address < 0) {
>  					fprintf(stderr, "Error: No address given\n");
> -					goto err_out;
> +					goto err_out_with_arg;
>  				}
>  			}
> =20
> @@ -234,7 +237,7 @@ int main(int argc, char *argv[])
>  				buf =3D malloc(len);
>  				if (!buf) {
>  					fprintf(stderr, "Error: No memory for buffer\n");
> -					goto err_out;
> +					goto err_out_with_arg;
>  				}
>  				memset(buf, 0, len);
>  				msgs[nmsgs].buf =3D buf;
> @@ -253,7 +256,7 @@ int main(int argc, char *argv[])
>  			raw_data =3D strtoul(arg_ptr, &end, 0);
>  			if (raw_data > 255) {
>  				fprintf(stderr, "Error: Data byte invalid\n");
> -				goto err_out;
> +				goto err_out_with_arg;
>  			}
>  			data =3D raw_data;
>  			len =3D msgs[nmsgs].len;
> @@ -270,7 +273,7 @@ int main(int argc, char *argv[])
>  				case '=3D': break;
>  				default:
>  					fprintf(stderr, "Error: Invalid data byte suffix\n");
> -					goto err_out;
> +					goto err_out_with_arg;
>  				}
>  			}
> =20
> @@ -283,7 +286,7 @@ int main(int argc, char *argv[])
> =20
>  		default:
>  			fprintf(stderr, "Error: Unnkown state in state machine!\n");
> -			goto err_out;
> +			goto err_out_with_arg;

I'd stick to err_out in this case. As this isn't supposed to happen,
you have no idea if printing argv[arg_idx] is relevant or not. And it
is likely to confuse the user.

>  		}
> =20
>  		arg_idx++;
> @@ -291,18 +294,18 @@ int main(int argc, char *argv[])
> =20
>  	if (state !=3D PARSE_GET_DESC || nmsgs =3D 0) {
>  		fprintf(stderr, "Error: Incomplete message\n");
> -		exit(1);
> +		goto err_out;
>  	}
> =20
>  	if (!yes && !confirm(filename, msgs, nmsgs))
> -		exit(0);
> +		goto out;
> =20
>  	rdwr.msgs =3D msgs;
>  	rdwr.nmsgs =3D nmsgs;
>  	nmsgs_sent =3D ioctl(file, I2C_RDWR, &rdwr);
>  	if (nmsgs_sent < 0) {
>  		fprintf(stderr, "Error: Sending messages failed: %s\n", strerror(errno=
));
> -		exit(errno);
> +		goto err_out;
>  	} else if (nmsgs_sent < nmsgs) {
>  		fprintf(stderr, "Warning: only %d/%d messages were sent\n", nmsgs_sent=
, nmsgs);
>  	}
> @@ -311,10 +314,17 @@ int main(int argc, char *argv[])
> =20
>  	print_msgs(msgs, nmsgs_sent, PRINT_READ_BUF | (verbose ? PRINT_HEADER |=
 PRINT_WRITE_BUF : 0));
> =20
> -	/* let Linux free malloced memory on termination */
> +out:

One space before labels please, so as to not break "diff -p".

> +	for (i =3D 0; i <=3D nmsgs; i++)
> +		free(msgs[i].buf);

It would be <, not <=3D.

Another approach is:

	for (; nmsgs >=3D 0; nmsgs--)
		free(msgs[nmsgs].buf);

which avoids introducing another loop variable.

> +
>  	exit(0);
> =20
> -err_out:
> +err_out_with_arg:
>  	fprintf(stderr, "Error: faulty argument is '%s'\n", argv[arg_idx]);
> +err_out:
> +	for (i =3D 0; i <=3D nmsgs; i++)
> +		free(msgs[i].buf);
> +
>  	exit(1);
>  }

Thanks for doing that.

--=20
Jean Delvare
SUSE L3 Support
