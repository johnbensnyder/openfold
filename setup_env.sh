BASE_DIR=`pwd`
pushd ~/anaconda3/envs/openfold_venv/lib/python3.9/site-packages/ \
&& patch -p0 < $BASE_DIR/lib/openmm.patch \
&& popd

wget --no-check-certificate -P openfold/resources \
    https://git.scicore.unibas.ch/schwede/openstructure/-/raw/7102c63615b64735c4941278d92b554ec94415f8/modules/mol/alg/src/stereo_chemical_props.txt
    
aws s3 cp --no-sign-request --region us-east-1 s3://openfold/openfold_params ./openfold/resources --recursive

wget -P openfold/resources https://storage.googleapis.com/alphafold/alphafold_params_2022-01-19.tar

tar --extract --verbose --file=openfold/resources/alphafold_params_2022-01-19.tar \
    --directory=openfold/resources/ --preserve-permissions

rm openfold/resources/alphafold_params_2022-01-19.tar

mkdir -p /tmp/ramdisk
chmod -R 777 /tmp/ramdisk